Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932602AbVJELDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbVJELDB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 07:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbVJELDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 07:03:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11424 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932602AbVJELDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 07:03:00 -0400
Subject: Re: [PATCH] Keys: Export user-defined keyring operations
From: Arjan van de Ven <arjan@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, Michael C Thompson <mcthomps@us.ibm.com>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <28129.1128509939@warthog.cambridge.redhat.com>
References: <OF7208B0E9.0AB77A04-ON87257090.007A1D4E-05257090.007A2207@us.ibm.com>
	 <28129.1128509939@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 13:02:38 +0200
Message-Id: <1128510159.2920.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 11:58 +0100, David Howells wrote:
> The attached patch exports user-defined key operations so that those who wish
> to define their own key type based on the user-defined key operations may do
> so (as has been requested).
> 
> The header file created has been placed into include/keys/user-type.h, thus
> creating a directory where other key types may also be placed. Any objections
> to doing this?

since this is new unique-to-linux functionality, could you please
consider making the exports _GPL please?


