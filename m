Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWEJFfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWEJFfO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 01:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWEJFfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 01:35:13 -0400
Received: from CPE-144-136-172-108.sa.bigpond.net.au ([144.136.172.108]:38745
	"EHLO grove.modra.org") by vger.kernel.org with ESMTP
	id S964825AbWEJFfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 01:35:11 -0400
Date: Wed, 10 May 2006 15:05:10 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Olof Johansson <olof@lixom.net>
Cc: Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
Message-ID: <20060510053510.GB24458@bubble.grove.modra.org>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com> <20060510051649.GD1794@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510051649.GD1794@lixom.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 12:16:50AM -0500, Olof Johansson wrote:
> ... so, as the PACA gets deprecated, the bloat will go away again.

We can also lose one instruction per tls access, if I can manage to
teach gcc a trick or two.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
