Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVCRP3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVCRP3n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 10:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVCRP1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 10:27:14 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:55779 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261641AbVCRPZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:25:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dBdu2a4YfSoh1WCz/8NonunIgFPWP+wClhplSrQmwsS0v87q9O1JyTUW7YIlBJmTkpn7fqYeFN3Wqf4RFp1+HOaPQmVGQfxdRwaUbUp1TfsNKbrZcQuxgH+zjy/lfqxYXwdWVzGtyP91t6Odd3rkDVvDCV7qIm/Qu4aGAMPYZzA=
Message-ID: <2a4f155d05031807256826bf79@mail.gmail.com>
Date: Fri, 18 Mar 2005 17:25:35 +0200
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Subject: Re: 2.6.11: CDROM_SEND_PACKET as non-root?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050318154546.41b18776@phoebee>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050318154546.41b18776@phoebee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

growisofs works as a non-root user here.


On Fri, 18 Mar 2005 15:45:46 +0100, Martin Zwickel
<martin.zwickel@technotrend.de> wrote:
> Hi all!
> 
> I have a small question:
> What do I have to do, to let the ioctl CDROM_SEND_PACKET work as a
> non-root user under 2.6.11?
> 
> I try to burn a DVD with growisofs as a non-root user without success.
> 
> I know that there were some changes about access restriction (since
> 2.6.8), but I haven't found anything to get a clue about the current
> status.
> 
> So is it just impossible to send a packet to the DVD burner without root
> access? Do I have to use a wrapper that sets the effective user id to
> root and then runs growisofs?
> 
> 
> It's friday, so sorry for that stupid question, but a comment on that
> would be fine :)
> 
> Regards,
> Martin
> 
> -- 
> MyExcuse:
> Recursive traversal of loopback mount points
> 
> Martin Zwickel <martin.zwickel@technotrend.de>
> Research & Development
> 
> TechnoTrend AG <http://www.technotrend.de>
> 
> 

-- 
Time is what you make of it
