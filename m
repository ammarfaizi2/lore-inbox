Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161149AbWF0QSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbWF0QSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161150AbWF0QSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:18:14 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:10917 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161149AbWF0QSO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:18:14 -0400
Date: Tue, 27 Jun 2006 11:17:55 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Stephan M?ller <smueller@chronox.de>
Subject: Re: [PATCH 01/06] ecryptfs: Validate minimum header extent size
Message-ID: <20060627161755.GD2795@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <200606270146.27959.smueller@chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606270146.27959.smueller@chronox.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 01:46:27AM +0200, Stephan M?ller wrote:
> The encrypted file ecryptfs maintains has in the first page meta
> data that is needed for ecryptfs operation. As the encrypted file is
> untrusted, every bit read of that file must be validated.
> 
> The patch ensures that crypt_stat->num_header_extents_at_front is
> checked for improper values.

All of Stephan's patches in this set, with my fix on top of #3, look
good to me.

Mike
