Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVHFDsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVHFDsP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 23:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVHFDsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 23:48:15 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:13231 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261980AbVHFDsO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 23:48:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ae02Sdk7PIJG/H2mDp2zOE+Rl1rPDfUd8uco6guNnOIjGgV5GzkbQqQRB7MtNHX9k+o8H7zHnksGOp6J6jwqfMPVhYOHZdcb5V811u3FswICM4E4XQLA8vQmxmH80QoQ1QMW7Q3HRpR3/36ubO9AGvJsGnsku3HbuQE+csrQg44=
Message-ID: <9e473391050805204849fb2085@mail.gmail.com>
Date: Fri, 5 Aug 2005 23:48:13 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050806004205.GE5370@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050728040544.GA12476@kroah.com>
	 <20050728054914.GA13904@kroah.com>
	 <20050728070455.GF9985@gaz.sfgoth.com>
	 <9e47339105072805545766f97d@mail.gmail.com>
	 <20050728190352.GA29092@kroah.com>
	 <9e47339105072812575e567531@mail.gmail.com>
	 <20050728202214.GA9041@gaz.sfgoth.com>
	 <9e473391050728132757a75d5f@mail.gmail.com>
	 <9e4733910507291150fe8f839@mail.gmail.com>
	 <20050806004205.GE5370@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/05, Greg KH <greg@kroah.com> wrote:
> On Fri, Jul 29, 2005 at 02:50:44PM -0400, Jon Smirl wrote:
> > Greg, is this ok for your tree now or does it need more work?
> 
> It's in my queue, will add it to the tree next week.  Sorry for the
> delay, was at OSCON this week...

Glad to see this. After it lands in the tree I'll fix up about ten
places where I have attribute processing wrong because of this. Is
there some place in the sysfs doc that this can be mentioned?

Another thing that should be cleared up is if the attributes are
described by length or zero termination. Right now they get both. I
suspect the right answer here is supposed to be by length.

-- 
Jon Smirl
jonsmirl@gmail.com
