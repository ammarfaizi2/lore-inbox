Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbVEMRBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbVEMRBq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 13:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVEMRBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 13:01:46 -0400
Received: from mail.dvmed.net ([216.237.124.58]:52437 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262434AbVEMRAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 13:00:11 -0400
Message-ID: <4284DD16.8090405@pobox.com>
Date: Fri, 13 May 2005 13:00:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] make MII no longer user visible
References: <20050513035257.GC3603@stusta.de>
In-Reply-To: <20050513035257.GC3603@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> MII is a classical example of a helper option no user should ever see.

Incorrect.

It's the classic example of an option that distributors may want to 
build as a module, even if no shipped modules need it, to enable net 
driver development and use in their kernel.

	Jeff



