Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbVCBWOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVCBWOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVCBWOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:14:30 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:33573 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262504AbVCBWNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:13:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Upw83fl7OVgmJDP6sw4597F+7fV/Lh77qbqJT5o4LIqyFpg9G4ivIYY+0LrkNb7hvyY/JTSjdcTzSmC4z5lpRrbH14kWbOaXWYOp292Cdx2o8bn6DjsC8yDozeWUDdPzfYzG3a/HFUjsCDXJ7kn6W3dM56fuNMoz9lRrY1q6VxM=
Message-ID: <d120d500050302141379f0cb9@mail.gmail.com>
Date: Wed, 2 Mar 2005 17:13:14 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Ralph Corderoy <ralph@inputplus.co.uk>
Subject: Re: Documentation for krefs
Cc: Corey Minyard <cminyard@mvista.com>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200503022130.j22LU6H02463@blake.inputplus.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <422617F1.2080404@mvista.com>
	 <200503022130.j22LU6H02463@blake.inputplus.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Mar 2005 21:30:06 +0000, Ralph Corderoy
<ralph@inputplus.co.uk> wrote:
> > +This way, it doesn't matter what order the two threads handle the
> > +data, the put handles knowing when the data is free and releasing it.
> 
> s/put/kref_put()/
>

What about s/is free/is not referenced anymore/

-- 
Dmitry
