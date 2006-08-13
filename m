Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWHMNDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWHMNDT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 09:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWHMNDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 09:03:18 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:53652 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751181AbWHMNDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 09:03:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=f8cmc2Lx/Y1eBkajdRkZbXHzyH/3yxrpgYopAZILZBkZitE/9OXMyvk781ToCUM2BsWCft1MLofbwExXCW+Yn1QM7kSw7N6wlfP1djP37eoeyTMJSvOR5Uoj+9jS9LlYRC4ahyJqqijhNuxAu2Ubax4coTWYoFKkA3YRQgGAAU4=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: linux-scsi@vger.kernel.org
Subject: [PATCH 3/4] aic7xxx: remove excessive inlining
Date: Sun, 13 Aug 2006 15:03:07 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200608131457.21951.vda.linux@googlemail.com> <200608131458.52804.vda.linux@googlemail.com> <200608131502.10664.vda.linux@googlemail.com>
In-Reply-To: <200608131502.10664.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608131503.07987.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 August 2006 15:02, Denis Vlasenko wrote:
> Basically, patches deinline some functions, mainly those
> which perform port I/O.

ahd_suspend/resume are not used. #ifdef them out.
--
vda
