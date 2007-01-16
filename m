Return-Path: <linux-kernel-owner+w=401wt.eu-S1751081AbXAPKqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbXAPKqo (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 05:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbXAPKqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 05:46:44 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:45871 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbXAPKqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 05:46:44 -0500
Date: Tue, 16 Jan 2007 05:46:33 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Mark struct super_operations const
Message-ID: <20070116104633.GD21546@filer.fsl.cs.sunysb.edu>
References: <11689404544064-git-send-email-jsipek@cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11689404544064-git-send-email-jsipek@cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...  
> -static struct super_operations openprom_sops = { 
> +const static struct super_operations openprom_sops = { 

About to send a new patch to make that 'static const' instead :)

Jeff.

-- 
Intellectuals solve problems; geniuses prevent them
		- Albert Einstein
