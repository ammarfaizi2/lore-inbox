Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbTENGQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 02:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTENGP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 02:15:59 -0400
Received: from holomorphy.com ([66.224.33.161]:61120 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262050AbTENGPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 02:15:50 -0400
Date: Tue, 13 May 2003 23:28:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ahc_linux_map_seg() compile/style/data corruption fixes
Message-ID: <20030514062831.GH2444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20030514044934.GC29926@holomorphy.com> <498302704.1052893137@aslan.scsiguy.com> <20030514062134.GG2444@holomorphy.com> <504652704.1052893608@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <504652704.1052893608@aslan.scsiguy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 12:18:57AM -0600, Justin T. Gibbs wrote:
>>> This was obvious from code inspection.

>> ISTR a debate where it was claimed the constant would be implicitly
>> promoted.

On Wed, May 14, 2003 at 12:26:48AM -0600, Justin T. Gibbs wrote:
> Promotion to long is all that is guaranteed at least up to C89.  I
> don't think that C99 has changed this.  The use of ULL in the code
> is required.

I thought they were wrong too, hence the patch. =)


-- wli
