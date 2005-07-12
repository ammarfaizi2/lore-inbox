Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVGLWR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVGLWR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbVGLWRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:17:11 -0400
Received: from [194.90.237.34] ([194.90.237.34]:42146 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262028AbVGLWQh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:16:37 -0400
Date: Wed, 13 Jul 2005 01:17:25 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Tom Duffy <tduffy@sun.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: Re: [PATCH 3/27] Add MAD helper functions
Message-ID: <20050712221725.GB14316@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <1121203934.14638.27.camel@duffman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121203934.14638.27.camel@duffman>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Tom Duffy <tduffy@sun.com>:
> These seem to be mostly coming from cpu_to_be*() and be*_to_cpu().  Is
> there a good rule of thumb for fixing these warnings?

Yes.
Use attributes like __be32 and friends appropriately.

-- 
MST
