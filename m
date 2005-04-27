Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVD0RYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVD0RYJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVD0RYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:24:04 -0400
Received: from peabody.ximian.com ([130.57.169.10]:52891 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261810AbVD0RVH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:21:07 -0400
Subject: Re: any way to find out kernel memory usage?
From: Robert Love <rml@novell.com>
To: Chris Friesen <cfriesen@nortel.com>
Cc: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <426FC46C.4070306@nortel.com>
References: <426FBFED.9090409@nortel.com> <426FC0FE.2090900@oktetlabs.ru>
	 <426FC46C.4070306@nortel.com>
Content-Type: text/plain
Date: Wed, 27 Apr 2005 13:20:38 -0400
Message-Id: <1114622438.10836.8.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-27 at 10:57 -0600, Chris Friesen wrote:

> I assume kmalloc/vmalloc use the "size-x" slabs?

kmalloc, yes.

vmalloc is separate, totally unrelated, space.

Statistics are in /proc/meminfo.

	Robert Love


