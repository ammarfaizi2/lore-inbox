Return-Path: <linux-kernel-owner+w=401wt.eu-S932100AbXACVuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbXACVuP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 16:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbXACVuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 16:50:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:24529 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbXACVuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 16:50:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GqhIoJbVJlvY4SBwO5m/PyJTvXC0BLOXcKZo6cBvKnjMD1X3AXWN51ibuBeFpeZbe9zKDgaOSt3DkJ/MvrGk97CRiDVL5EeonyxGJ3NDUp4U1d8EGH+Zd3HSiefatf+Cu6HeppnXNKUW/c0rPQwNeHhcBrial+WspuHfuAR6F28=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel + gcc 4.1 = several problems
Date: Wed, 3 Jan 2007 22:48:38 +0100
User-Agent: KMail/1.8.2
Cc: Grzegorz Kulewski <kangur@polcom.net>, Alan <alan@lxorguk.ukuu.org.uk>,
       Mikael Pettersson <mikpe@it.uu.se>, s0348365@sms.ed.ac.uk,
       76306.1226@compuserve.com, akpm@osdl.org, bunk@stusta.de,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       yanmin_zhang@linux.intel.com
References: <200701030212.l032CDXe015365@harpo.it.uu.se> <200701032047.02941.vda.linux@googlemail.com> <Pine.LNX.4.64.0701031225090.4473@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701031225090.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701032248.38653.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 January 2007 21:38, Linus Torvalds wrote:
> On Wed, 3 Jan 2007, Denis Vlasenko wrote:
> > 
> > Why CPU people do not internally convert cmov into jmp,mov pair?
> 
...
> It really all boils down to: there's simply no real reason to use cmov. 
> It's not horrible either, so go ahead and use it if you want to, but don't 
> expect your code to really magically run any faster.

IOW: yet another slot in instruction opcode matrix and thousands of
transistors in instruction decoders are wasted because of this
"clever invention", eh?
--
vda
