Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWFBEaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWFBEaj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 00:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWFBEaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 00:30:39 -0400
Received: from main.gmane.org ([80.91.229.2]:16326 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751109AbWFBEai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 00:30:38 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: OpenGL-based framebuffer concepts
Date: Fri, 02 Jun 2006 07:34:48 +0300
Message-ID: <pan.2006.06.02.04.34.36.227639@sci.fi>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605302314.25957.dhazelton@enter.net> <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com> <200605310026.01610.dhazelton@enter.net> <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com> <20060601092807.GA7111@localhost.localdomain> <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com> <21d7e9970606011815y226ebb86ob42ec0421072cf07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cs181093116.pp.htv.fi
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2006 11:15:47 +1000, Dave Airlie wrote:

>> Without specifying a design here are a few requirements I would have:
>>
>> 1) The kernel subsystem should be agnostic of the display server. The
>> solution should not be X specific. Any display system should be able
>> to use it, SDL, Y Windows, Fresco, etc...
> 
> of course, but that doesn't mean it can't re-use X's code, they are
> the best drivers we have. you forget everytime that the kernel fbdev
> drivers aren't even close, I mean not by a long long way apart from
> maybe radeon.

matroxfb is clearly better than the X driver. atyfb too IMO.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/


