Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266891AbUGVR5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUGVR5R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 13:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266883AbUGVR4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 13:56:35 -0400
Received: from [213.146.154.40] ([213.146.154.40]:48107 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266875AbUGVRzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 13:55:15 -0400
Date: Thu, 22 Jul 2004 18:55:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: linux-ia64@vger.kernel.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: Altix I/O code re-org
Message-ID: <20040722175514.GA15391@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200407221514.i6MFEVag084696@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407221514.i6MFEVag084696@fsgi900.americas.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 10:14:31AM -0500, Pat Gefre wrote:
> The code is organized in the following manner:
> 
> diffs_of_common_c_files - this has the diffs of 'C' files that were changed
>                           but not renamed.
> diffs_of_common_h_files - this has the diffs of include files that were changed
>                           but not renamed.
> diffs_of_renamed_files  - this has the diffs of all files that were renamed.
> 
> 
> source_code.tar.gz      - tarball of new source files.
> Source_code_tree/       - directory of new source files.

I haven't looked at the code yet (and won't until I'm back from OLS), but
for sure thats not how we will merge the code.  Please split it into small,
self-contained patches that do one thing each. 

