Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTEUJZw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 05:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbTEUJZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 05:25:52 -0400
Received: from tag.witbe.net ([81.88.96.48]:15630 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S261845AbTEUJZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 05:25:52 -0400
From: "Paul Rolland" <rol@as2917.net>
To: "'Andrew Morton'" <akpm@digeo.com>, <maneesh@in.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       <dipankar@in.ibm.com>, <Paul.McKenney@us.ibm.com>
Subject: Re: [patch 1/2] vfsmount_lock
Date: Wed, 21 May 2003 11:38:40 +0200
Message-ID: <00fa01c31f7c$c33f30d0$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20030521023523.655bc8f2.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spin_unlock ???

> >  -	return p;
> >  +	spin_lock(&vfsmount_lock);
> >  +	return found;
> >   }
> 
> err, how many times do you want to spin that lock?
> 

Paul

