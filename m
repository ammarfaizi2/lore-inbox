Return-Path: <linux-kernel-owner+w=401wt.eu-S932157AbXAQJ0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbXAQJ0h (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 04:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbXAQJ0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 04:26:37 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:54228 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932157AbXAQJ0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 04:26:36 -0500
Message-ID: <45ADE7CB.2080701@gmail.com>
Date: Wed, 17 Jan 2007 10:09:08 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: gregkh@suse.de
Cc: grundler@parisc-linux.org, akpm@osdl.org, greg@kroah.com,
       kaneshige.kenji@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       seto.hidetoshi@jp.fujitsu.com
Subject: Re: patch pci-rework-documentation-pci.txt.patch added to gregkh-2.6
 tree
References: <20070116222721.EA942B41673@imap.suse.de>
In-Reply-To: <20070116222721.EA942B41673@imap.suse.de>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gregkh@suse.de wrote:
[...]
> +Tips on when/where to use the above attributes:
> +	o The module_init()/module_exit() functions (and all
> +	  initialization functions called _only_ from these)
> +	  should be marked __init/__exit.
> +
> +	o Do not mark the struct pci_driver.
> +
> +	o The ID table array should be marked __devinitdata.

Is that correct? It panics somewehere IIRC?

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
