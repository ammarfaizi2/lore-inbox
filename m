Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135723AbRDZRXg>; Thu, 26 Apr 2001 13:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135725AbRDZRX0>; Thu, 26 Apr 2001 13:23:26 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:64439 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S135723AbRDZRXN>; Thu, 26 Apr 2001 13:23:13 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200104261722.SAA16939@mauve.demon.co.uk>
Subject: Re: [PATCH] Single user linux
To: brownfld@irridia.com (Ken Brownfield)
Date: Thu, 26 Apr 2001 18:22:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200104261700.MAA13391@asooo.flowerfire.com> from "Ken Brownfield" at Apr 26, 2001 10:00:02 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> On Thursday, April 26, 2001, at 07:03 AM, <imel96@trustix.co.id> wrote:
> > he owns the computer, he may do anything he wants.
<snip>
> Any OS worth its weight in silicon will make a distinction between 
> blessed and unblessed users.  It can be phrased in different ways -- 
> root vs. non-root, admin vs. non-admin.  But no one should EVER log in 
> to a machine as root.  Period. (1)

Also, there is another reason.
If you'r logged in as root, then any exploitable bug in large programs,
be it netscape, realplayer, wine, vmware, ... means that the 
cracker owns your machine.
If they are not, then the cracker has to go through another significant
hoop, in order to get access to the machine.
For optimal security, you can do things like running netscape and other 
apps under unpriveledged users, where they only have access to their own
files.

(Note, netscape/.. are just used as examples, I'm not saying they are
more buggy than others, just large, and hard to get bug-free)

