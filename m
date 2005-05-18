Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVEROZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVEROZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVEROLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:11:02 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11749 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262193AbVEROC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:02:59 -0400
Date: Wed, 18 May 2005 15:02:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS lstat() _very_ slow on SMP
Message-ID: <20050518140258.GA22587@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org
References: <20050516162506.GB19415@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050516162506.GB19415@fi.muni.cz>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2005 at 06:25:06PM +0200, Jan Kasprzak wrote:
> 	Hi all,
> 
> 	I have a big XFS volume on my fileserver, and I have noticed that
> making an incremental backup of this volume is _very_ slow. The incremental
> backup essentially checks mtime of all files on this volume, and it
> takes ~4ms of _system_ time (i.e. no iowait or what) to do a lstat().

Thanks a lot for the report, I'll investigate what's going on once I get
a little time.  (Early next week I hope)

