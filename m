Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286647AbSAZTnb>; Sat, 26 Jan 2002 14:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286672AbSAZTnY>; Sat, 26 Jan 2002 14:43:24 -0500
Received: from mail.cert.uni-stuttgart.de ([129.69.16.17]:50876 "HELO
	Mail.CERT.Uni-Stuttgart.DE") by vger.kernel.org with SMTP
	id <S286647AbSAZTnQ>; Sat, 26 Jan 2002 14:43:16 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
In-Reply-To: <200201251550.g0PFoIPa002738@tigger.cs.uni-dortmund.de>
	<200201250802.32508.bodnar42@phalynx.dhs.org>
	<jeelkes8y5.fsf@sykes.suse.de> <a2sv2s$ge3$1@penguin.transmeta.com>
	<20020126173303.GC11344@fefe.de>
From: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Date: Sat, 26 Jan 2002 20:40:15 +0100
In-Reply-To: <20020126173303.GC11344@fefe.de> (Felix von Leitner's message
 of "Sat, 26 Jan 2002 18:33:03 +0100")
Message-ID: <87bsfgoq8w.fsf@CERT.Uni-Stuttgart.DE>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner <usenet-20020126@fefe.de> writes:

> What do you mean with "does not work together with other optimizations"?

You cannot both enable -Os and prefetching support, for example (at
least with certain GCC versions).

-- 
Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
