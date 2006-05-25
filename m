Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbWEYV1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWEYV1O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 17:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWEYV1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 17:27:14 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:41360 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id S1030421AbWEYV1N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 17:27:13 -0400
Date: Thu, 25 May 2006 14:27:13 -0700 (PDT)
From: alan <alan@clueserver.org>
X-X-Sender: alan@blackbox.fnordora.org
To: devmazumdar <dev@opensound.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
In-Reply-To: <e55715+usls@eGroups.com>
Message-ID: <Pine.LNX.4.64.0605251425390.19028@blackbox.fnordora.org>
References: <e55715+usls@eGroups.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2006, devmazumdar wrote:

> How does one check the existence of the kernel source RPM (or deb) on
> every single distribution?.
>
> We know that rpm -qa | grep kernel-source works on Redhat, Fedora,
> SuSE, Mandrake and CentOS - how about other RPM based distros? How
> about debian based distros?. There doesn't seem to be a a single
> conherent naming scheme.

Actually it does not on later versions of fedora (4 & 5).  The headers are 
included, but not the source.  If you want to build modules, you must have 
kernel-devel installed.

-- 
"Waiter! This lambchop tastes like an old sock!" - Sheri Lewis
