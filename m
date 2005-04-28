Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVD1AQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVD1AQE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 20:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVD1AQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 20:16:04 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:22565 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262122AbVD1AP4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 20:15:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RjqiXlo+wjzq7Zaq53gJ9xcwGnEz9/qMAUP2krLQADoC+IK3zimv3YysbahL0kpcrfd+RJkV6bMoRJfnXUzbvrBD4iDH57L7SDj59TNYuWFG4wYU5YBhMKnbeDRnK8wHeXOMRg8YUz11WgDHeaF08wPTXTriml4j9l65ekBk+k0=
Message-ID: <d4757e600504271715493fd507@mail.gmail.com>
Date: Wed, 27 Apr 2005 20:15:55 -0400
From: Joe <joecool1029@gmail.com>
Reply-To: Joe <joecool1029@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Device Node Issues with recent mm's and udev
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
In-Reply-To: <20050427170106.782ea4c3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d4757e6005042716523af66bae@mail.gmail.com>
	 <20050427170106.782ea4c3.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I will test when its out.

>Is the device node in /dev actually a block-special device, or is is coming
>up as a regular file or something?

It appears as a special block device before an image is sent.  After
that it appears as a regular file.
