Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280218AbRJaNyQ>; Wed, 31 Oct 2001 08:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280213AbRJaNyG>; Wed, 31 Oct 2001 08:54:06 -0500
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:7686 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S280218AbRJaNxz>; Wed, 31 Oct 2001 08:53:55 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [lkml] Re: apm suspend broken ?
In-Reply-To: <Pine.LNX.4.33.0110310208410.2024-100000@co2.localdomain>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: 31 Oct 2001 08:54:31 -0500
In-Reply-To: <Pine.LNX.4.33.0110310208410.2024-100000@co2.localdomain>
Message-ID: <9cfbsinncdk.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal Lengard <pascal.lengard@wanadoo.fr> writes:

> I tested "plain" 2.4.12 from Linus and it suffer the same problem.
> Pressing Fn+Suspend does nothing on my Dell Latitude C600, so I thought
> it would not be usefull to test against 2.4.12-ac. Tell me if I am plain
> wrong on this, otherwise, I guess my problem is not exactly the same than 
> Samuli Suonpaa's.

just for other data points, 2.4.7 (RedHat), 2.4.9 (RedHat), and
2.4.12-ac6 respond OK to Fn-Suspend on my C600.  

occasionally i get a suspend that won't resume correctly; the
framebuffer gets hosed such that it looks like the screen is cut into
vertical strips and rearranged.  but Fn-Suspend works, and i can
resume, and the machine is still running fine (i.e., i can reboot it
if i can maneuver the mouse to a window ;-).

what i've never gotten to work on the C600 is suspend on closing the
lid.  Worked great on my old Latitude CS... gotta love Dell, the cases
look the same but everything inside is a crapshoot.

ian
