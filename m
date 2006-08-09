Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWHIURH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWHIURH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWHIURH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:17:07 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:7280 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751346AbWHIURG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:17:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=VFillbbj2pwpqy6eel8ZB7gcmuxh9aUioeE72v0YRnIv5DS56qp1/r+1lnNiBI1/zKUq4480a3XLmlqi6C0J482bsywq3P+TdKIBz+veJDnhmqj7+6/uF/HtouLtANHMqgg57dEuseJv7jjVuO70uu36npwe9Z5Xsr7fvNiC4v4=
Message-ID: <e9e943910608091317p37bdbd66t91bc1e16c3d9986a@mail.gmail.com>
Date: Wed, 9 Aug 2006 21:17:04 +0100
From: "Duane Griffin" <duaneg@dghda.com>
To: "Molle Bestefich" <molle.bestefich@gmail.com>
Subject: Re: ext3 corruption
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
	 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
	 <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
	 <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
	 <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>
	 <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
X-Google-Sender-Auth: 84b00e6f1f1bdaa7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/06, Molle Bestefich <molle.bestefich@gmail.com> wrote:
[snip]
> And what will e2fsck do to my dear filesystem if I let it have a go at it?

To be safe, run it on an image of your filesystem first. You can use
the dd command to take the image, then run e2fsck on it. Afterwards
mount it and make sure everything looks kosher. That is assuming you
have enough spare space, of course. If not then you should at least
run e2fsck with -n first to find out what it wants to do. Personally,
my risk tolerance would be closely correlated with the quality of my
backups.

Cheers,
Duane.

-- 
"I never could learn to drink that blood and call it wine" - Bob Dylan
