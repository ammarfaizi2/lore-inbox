Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263864AbUEMHN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263864AbUEMHN0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 03:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbUEMHN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 03:13:26 -0400
Received: from holomorphy.com ([207.189.100.168]:35516 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263850AbUEMHNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 03:13:21 -0400
Date: Thu, 13 May 2004 00:11:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Muli Ben-Yehuda <mulix@mulix.org>,
       David Gibson <david@gibson.dropbear.id.au>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Adam Litke <agl@us.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: More convenient way to grab hugepage memory
Message-ID: <20040513071158.GT1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Muli Ben-Yehuda <mulix@mulix.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Adam Litke <agl@us.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
References: <20040513055520.GF27403@zax> <20040513060549.GA12695@mulix.org> <20040513065912.GR1397@holomorphy.com> <20040513070434.GS1397@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513070434.GS1397@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 12:04:34AM -0700, William Lee Irwin III wrote:
> That would be:

At some point while I wasn't looking hugetlb_zero_setup() got an
ERR_PTR(-ENOSYS) implementation for #ifndef CONFIG_HUGETLB_PAGE so the
whole create_hugetlb_file() bit is unnecessary.


-- wli
