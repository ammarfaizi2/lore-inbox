Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266931AbTGMKCq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 06:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270197AbTGMKCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 06:02:46 -0400
Received: from ip212-226-133-178.adsl.kpnqwest.fi ([212.226.133.178]:22928
	"EHLO jumper") by vger.kernel.org with ESMTP id S266931AbTGMKCp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 06:02:45 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: agpgart, nforce2, radeon and agp fastwrite
From: Jaakko Niemi <liiwi@lonesom.pp.fi>
Date: Sun, 13 Jul 2003 13:17:33 +0300
Message-ID: <87oezyg282.fsf@jumper.lonesom.pp.fi>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dave Jones wrote:
>On Sat, Jul 12, 2003 at 05:51:42PM +0200, Jan Dittmer wrote:
> > just took me half a hour to figure out. On nforce2 you have to disable
> > agp fastwrites, otherwise X locks hard on startup with the following
> > (from serial console).
> > ...
> >
> > Without AGP Fastwrites turned on, it all works wonderful. Just if
> > anybody encounters the same problem.
> > Mainboard is nForce2 based, graphics is radeon 8500le (R200).
>
>Could be that the nforce & radeon don't play well together.
>Anyone using fast writes without problems with non-ATI cards & nforce ?
>If it works there, it's trivial to blacklist ATI cards and make them
>unable to enable fast writes in the gart driver.

 Turning on fastwrites produces hangs on at least four different VIA based
 motherboards and five different radeons.

                       --j

