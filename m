Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbVHXOVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbVHXOVe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 10:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbVHXOVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 10:21:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17857 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751024AbVHXOVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 10:21:34 -0400
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Arjan van de Ven <arjan@infradead.org>
To: Hiro Yoshioka <hyoshiok@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050824.231156.278740508.hyoshiok@miraclelinux.com>
References: <20050818.201138.607962419.hyoshiok@miraclelinux.com>
	 <98df96d30508181629d85edb5@mail.gmail.com>
	 <20050823.081246.846946371.hyoshiok@miraclelinux.com>
	 <20050824.231156.278740508.hyoshiok@miraclelinux.com>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 16:21:23 +0200
Message-Id: <1124893284.3237.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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

On Wed, 2005-08-24 at 23:11 +0900, Hiro Yoshioka wrote:
> Hi,
> 
> The following patch does not use MMX regsiters so that we don't have
> to worry about save/restore the FPU/MMX states.
> 
> What do you think?

excellent!


