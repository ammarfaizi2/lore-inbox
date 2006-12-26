Return-Path: <linux-kernel-owner+w=401wt.eu-S932738AbWLZR5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738AbWLZR5O (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 12:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbWLZR5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 12:57:14 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42944 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932738AbWLZR5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 12:57:14 -0500
Date: Tue, 26 Dec 2006 17:56:42 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: "Christopher S. Aker" <caker@theshore.net>,
       Patrick McHardy <kaber@trash.net>,
       Santiago Garcia Mantinan <manty@manty.net>,
       linux-kernel@vger.kernel.org, ebtables-devel@lists.sourceforge.net
Subject: Re: ebtables problems on 2.6.19.1 *and* 2.6.16.36
Message-ID: <20061226175642.GL17561@ftp.linux.org.uk>
References: <200612252344_MC3-1-D65C-20B2@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612252344_MC3-1-D65C-20B2@compuserve.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 25, 2006 at 11:42:32PM -0500, Chuck Ebbert wrote:
> ebtables: don't compute gap until we know we have an ebt_entry
> 
> We must check the bitmap field to make sure we have an ebt_entry and
> not an ebt_entries struct before using fields from ebt_entry.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

Acked-by: Al Viro <viro@zeniv.linux.org.uk>

My fault.
