Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262688AbVF2Vea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbVF2Vea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 17:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVF2Ve0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 17:34:26 -0400
Received: from rgminet01.oracle.com ([148.87.122.30]:33506 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S262549AbVF2VeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 17:34:14 -0400
Date: Wed, 29 Jun 2005 14:30:38 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] CONFIGFS_FS shouldn't be user-visible
Message-ID: <20050629213038.GA23823@ca-server1.us.oracle.com>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, ocfs2-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
References: <20050624080315.GC26545@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624080315.GC26545@stusta.de>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 10:03:15AM +0200, Adrian Bunk wrote:
> I haven't found any reason why CONFIGFS_FS is user-visible.
> Other parts of the kernel using configfs should simply select it.

	Doesn't work for external modules that might want to use it.
Imagine that configfs gets merged before OCFS2, which depends on it.

Joel

-- 

"There is shadow under this red rock.
 (Come in under the shadow of this red rock)
 And I will show you something different from either
 Your shadow at morning striding behind you
 Or your shadow at evening rising to meet you.
 I will show you fear in a handful of dust."

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
