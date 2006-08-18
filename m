Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWHRMRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWHRMRz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbWHRMRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:17:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17047 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030349AbWHRMRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:17:53 -0400
Subject: Re: [2.6.19 PATCH 3/7] ehea: queue management
From: Arjan van de Ven <arjan@infradead.org>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: netdev <netdev@vger.kernel.org>, Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>
In-Reply-To: <200608181331.19501.ossthema@de.ibm.com>
References: <200608181331.19501.ossthema@de.ibm.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 18 Aug 2006 14:17:31 +0200
Message-Id: <1155903451.4494.168.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	queue->queue_length = nr_of_pages * pagesize;
> +	queue->queue_pages = vmalloc(nr_of_pages * sizeof(void *));


wow... is this really so large that it warrants a vmalloc()???


