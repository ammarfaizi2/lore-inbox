Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270158AbUJTL1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270158AbUJTL1k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 07:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270122AbUJTL1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 07:27:06 -0400
Received: from mail1.kontent.de ([81.88.34.36]:53961 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S270034AbUJTLSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 07:18:02 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Tomas Carnecky <tom@dbservice.com>
Subject: Re: my opinion about VGA devices
Date: Wed, 20 Oct 2004 13:18:25 +0200
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <417590F3.1070807@dbservice.com>
In-Reply-To: <417590F3.1070807@dbservice.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410201318.26430.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 20. Oktober 2004 00:10 schrieb Tomas Carnecky:
> I think this would make the suspend/resume/access/switching etc problems 
> much easier to solve since the kernel module could tell the library to 
> stop drawing/accessing mmap'ed memory etc. (or if the OpenGL rendering 
> is done in the kernel module it could just discard the render commands).
> Since the user has no direct access to mmap'ed memory and other critical 
> sections of the device, the driver can implement proper power managment 
> for suspend/resume etc.
> 
> Well... that's it.. any comments? I'm sure you have.. :)

You are making damn sure that there will be no useful bug reports
about problems with resuming from S3.

	Regards
		Oliver

