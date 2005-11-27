Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVK0CiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVK0CiX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 21:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbVK0CiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 21:38:23 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:34322 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750823AbVK0CiX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 21:38:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aYVrVTzNxrLSyUJrSMuGxOlLNLqyhYLYDMpb6I7Mb2G21SEU5QDzfLf67jBa5nyHfS+RkXxYbVnEjYFKs0nXv8TOeo3ijPjuXJ1+icxBOXzp7D9b6dow2U29VjtLz4H1y5kDpnEJV3xEOMOb3nyiqPcBrF2LCMF0sztVnJ16rWg=
Message-ID: <9c21eeae0511261838ncec563v1739a1230347365b@mail.gmail.com>
Date: Sat, 26 Nov 2005 18:38:22 -0800
From: David Brown <dmlb2000@gmail.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: linux-2.6.14.tar.bz2 permissions
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <29495f1d0511261827s7984bea8l92149b8a3091e6d8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com>
	 <200511270138.25769.s0348365@sms.ed.ac.uk>
	 <29495f1d0511261746y12a0c356ueb3d5bb08aa6f6a@mail.gmail.com>
	 <200511270151.21632.s0348365@sms.ed.ac.uk>
	 <9c21eeae0511261756r65d0f4b7l96b0e1089c4c62bc@mail.gmail.com>
	 <29495f1d0511261827s7984bea8l92149b8a3091e6d8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Uh, untarring is the operation that needs to be non-root. So just have
> a build user or some other non-root user do the untarring and building
> (which is recommended by most anyways, IIRC). Then, as root (or via
> sudo) make modules_install install.

This isn't an excuse to have unsecure permissions when extracting as
root though.

- David Brown
