Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269200AbTGJK6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 06:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269199AbTGJK6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 06:58:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:53428
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S269200AbTGJK5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 06:57:44 -0400
Subject: Re: PATCH: seq_file interface to provide large data chunks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alexander Viro <viro@math.psu.edu>
In-Reply-To: <3F0D217B.4040900@intel.com>
References: <3F0D217B.4040900@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057835373.8028.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jul 2003 12:09:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-10 at 09:19, Vladimir Kondratiev wrote:
> seq_file interface, as it exist in last official kernel, never provides 
> more then one page for each 'read' call. Old read_proc_t did loop to 
> fill more than one page.

There is a merge of Al's additional seq_file stuff to 2.4 floating
around (its in -ac for one) that may be a better thing to merge instead
if we want it 

Al ?

