Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbTKYQL6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 11:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTKYQL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 11:11:58 -0500
Received: from holomorphy.com ([199.26.172.102]:19131 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261640AbTKYQL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 11:11:57 -0500
Date: Tue, 25 Nov 2003 08:11:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Breno <brenosp@brasilsec.com.br>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Name of file
Message-ID: <20031125161150.GB8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Breno <brenosp@brasilsec.com.br>,
	Kernel List <linux-kernel@vger.kernel.org>
References: <001901c3b36e$19c19f80$34dfa7c8@bsb.virtua.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001901c3b36e$19c19f80$34dfa7c8@bsb.virtua.com.br>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 02:05:05PM -0200, Breno wrote:
> There is any way to know the name of file pointed by vma->vm_file ?

Check vma->vm_file->f_dentry.


-- wli
