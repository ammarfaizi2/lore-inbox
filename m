Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbUE1Ndj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUE1Ndj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 09:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbUE1Ndj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 09:33:39 -0400
Received: from main.gmane.org ([80.91.224.249]:32417 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262972AbUE1Ndi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 09:33:38 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: keyboard problem with 2.6.6
Date: Fri, 28 May 2004 15:33:21 +0200
Message-ID: <MPG.1b2111558bc2d299896a2@news.gmane.org>
References: <20040525201616.GE6512@gucio> <xb7hdu3fwsj.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-172-130.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sau Dan Lee wrote:
> Yeah.   They   say  the  input  system  "unifies"   the  interface  to
> keyboard/mouse  devices.   They're   also  proud  that  the  in-kernel
> keyboard/mouse drivers  are supporting more and more  devices.  But at
> the same  time, they're sacrificing  flexibility by moving  many codes
> into kernel.   (GPM supports more  mouse types!)  The new  system also
> breaks backward compatibility.

The new system has some ups and downs. The biggest "down", 
which is that of RAW mode not being available anymore (it's 
emulated!) could be circumvented by having both the RAW and 
translated codes move between layers.

Concerning GPM vs kernel support for mice, maybe we can hope 
for a merging of the efforts and a reduction of code 
duplication, if there is any?

Overall, I think that the new system *could* be a good starting 
point, but it still needs a *lot* of work.

(Now, if we could have any reply from the maintainers?)

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

