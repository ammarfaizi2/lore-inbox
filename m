Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132754AbRAaB4x>; Tue, 30 Jan 2001 20:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132349AbRAaB4o>; Tue, 30 Jan 2001 20:56:44 -0500
Received: from mercury.ukc.ac.uk ([129.12.21.10]:26578 "EHLO mercury.ukc.ac.uk")
	by vger.kernel.org with ESMTP id <S132754AbRAaB42>;
	Tue, 30 Jan 2001 20:56:28 -0500
To: migras@atlas.uvigo.es
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crash using DRI with 2.4.0 and 2.4.1
In-Reply-To: <3A7733F6.4070505@terra.es>
From: Adam Sampson <azz@gnu.org>
Organization: The Campaign For The Writing Of "a lot" As Two Words
In-Reply-To: Miguel Rodriguez Perez's message of "Tue, 30 Jan 2001 22:36:54
 +0100"
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Carlsbad Caverns)
Date: 31 Jan 2001 01:56:16 +0000
Message-ID: <87n1c832nz.fsf@cartman.azz.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Rodriguez Perez <migrax@terra.es> writes:

> Hi, I have a Matrox G200 card installed on an Ali motherboard.
> Sometimes when I use any opengl program my box crashes. It is more
> likely that it will crash if I have used the xvideo extension or the
> matroxfb, but this is not a must, it simply increases the chance of
> a crash, which is very high anyway.

> I have tried both 2.4.0 and 2.4.1 kernels with Xfree 4.0.2 both with
> the same results.

Are you sure you get the same results with 2.4.1? I'm in the exact
same position (G200 on a Gigabyte GA5AX with ALi M1541/3). There was a
patch to properly support AGP on these boards which went in between
2.4.0 and 2.4.1 which solved the problem for me (at least in 2.4.0; I
haven't tested DRI throughly in 2.4.1 yet).

-- 

Adam Sampson
azz@gnu.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
