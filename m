Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751695AbWHAR0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbWHAR0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbWHAR0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:26:04 -0400
Received: from mail.suse.de ([195.135.220.2]:62103 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751694AbWHAR0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:26:03 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] x86_64: remove lock prefix from is_at_popf() tests
Date: Tue, 1 Aug 2006 19:06:32 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200608010703_MC3-1-C6B1-9266@compuserve.com>
In-Reply-To: <200608010703_MC3-1-C6B1-9266@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608011906.32680.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 August 2006 13:00, Chuck Ebbert wrote:
> The lock prefix will cause an exception when used with the
> popf instruction, so no need to continue searching after it's
> found.

Applied thanks.
-Andi
