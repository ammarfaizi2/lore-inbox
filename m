Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTJMQKA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 12:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTJMQKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 12:10:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21518 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261890AbTJMQJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 12:09:57 -0400
Date: Mon, 13 Oct 2003 17:09:41 +0100
From: Dave Jones <davej@redhat.com>
To: Rik van Riel <riel@surriel.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] advansys compile fixes
Message-ID: <20031013160940.GA10677@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0310131151130.27244@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0310131151130.27244@imladris.surriel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13, 2003 at 11:52:02AM -0400, Rik van Riel wrote:

 > @@ -9258,7 +9258,6 @@ DvcAdvWritePCIConfigByte(
 >              ASC_PCI_ID2FUNC(asc_dvc->cfg->pci_slot_info)),
 >          offset, byte_data);
 >  #else /* CONFIG_PCI */
 > -    return 0;
 >  #endif /* CONFIG_PCI */
 >  }

Might as well lose the #else whilst we are at it.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
