Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbTEGNCW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 09:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbTEGNCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 09:02:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45955
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263162AbTEGNCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 09:02:22 -0400
Subject: Re: [RFC][Patch] fix for irq_affinity_write_proc v2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Keith Mannthey <kmannth@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030507022717.GV8978@holomorphy.com>
References: <1052247789.16886.261.camel@dyn9-47-17-180.beaverton.ibm.com>
	 <1052250874.1202.162.camel@dhcp22.swansea.linux.org.uk>
	 <20030507022717.GV8978@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052309780.3060.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 May 2003 13:16:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-05-07 at 03:27, William Lee Irwin III wrote:
> It's basically not working as specified for clustered hierarchical, and
> in truth the specification can never be met. As it stands most calls to
> it are lethal on such systems, especially those using physical destmod.
> 
> I'd prefer to have it redesigned for some validity checking and error
> returns as on such systems the impossible destinations serve no purpose
> but raising MCE's and/or deadlocking the box.

In which case I agree it does indeed make sense

