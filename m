Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262965AbVDLWFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbVDLWFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVDLWCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:02:18 -0400
Received: from mx2.mail.ru ([194.67.23.122]:42556 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S262965AbVDLV7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 17:59:54 -0400
From: Alexey Dobriyan <adobriyan@mail.ru>
To: torvalds@osdl.org
Subject: Re: [patch 134/198] officially deprecate register_ioctl32_conversion
Date: Wed, 13 Apr 2005 02:02:42 +0000
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@lst.de
References: <200504121032.j3CAWlw4005676@shell0.pdx.osdl.net>
In-Reply-To: <200504121032.j3CAWlw4005676@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504130202.42155.adobriyan@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 April 2005 10:32, akpm@osdl.org wrote:

> These have been deprecated since ->compat_ioctl when in, thus only a short
> deprecation period.  There's four users left: i2o_config, s390/z90crypy,
> s390/dasd and s390/zfcp and for the first two patches are about to be
> submitted to get rid of it.

> --- 25/Documentation/feature-removal-schedule.txt~officially-deprecate-register_ioctl32_conversion
> +++ 25-akpm/Documentation/feature-removal-schedule.txt

> +Why:	Replaced by ->compat_ioctl in file_operations and other method
> +	vecors.

vectors ?
