Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWFUKWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWFUKWF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 06:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWFUKWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 06:22:05 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:36059 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1751477AbWFUKWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 06:22:03 -0400
Message-ID: <44991622.2000109@s5r6.in-berlin.de>
Date: Wed, 21 Jun 2006 11:49:22 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ben Collins <bcollins@ubuntu.com>
CC: Linus Torvalds <torvalds@osdl.org>, Jody McIntyre <scjody@modernduck.com>,
       Andrew Morton <akpm@osdl.org>, linux1394-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] ieee1394 tree for 2.6.18
References: <44954102.3090901@s5r6.in-berlin.de>	<Pine.LNX.4.64.0606191902350.5498@g5.osdl.org>	<4497D014.1050704@s5r6.in-berlin.de>	<Pine.LNX.4.64.0606202001520.5498@g5.osdl.org> <1150871560.4517.13.camel@grayson>
In-Reply-To: <1150871560.4517.13.camel@grayson>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
> On Tue, 2006-06-20 at 20:07 -0700, Linus Torvalds wrote:
>> Ok, I pulled, and pushed out, but this tree is really problematic: the 
>> authorship info has been dropped entirely, it looks.
> 
> Sorry about that. Was caused by the patches coming in to me in non-git,
> non-mbox form, and me not taking the time to do each one by hand. Wont
> be like that after this.

Yes, I pointed Ben to patch files which lacked original rfc822 headers.
Sorry for causing trouble.

A related question: If a patch written by author A is forwarded via
e-mail by person B to git tree maintainer C, and C imports the mail with
git-am or git-applymbox --- will git catch the _last_ "From: " line
(hopefully listing the address of A) or the first "From: " line (which
contains the forwarding address of B) as author of the patch?

Similarly, will it care for the last or first "Subject: " line? (The
first line being the actual mail header, the last being a line in the
mail body or a line in a plain-text encoded attachment, that is.)

Thanks,
-- 
Stefan Richter
-=====-=-==- -==- =-=-=
http://arcgraph.de/sr/
