Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752226AbWCPHbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbWCPHbo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 02:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752228AbWCPHbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 02:31:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14267 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752224AbWCPHbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 02:31:43 -0500
Date: Thu, 16 Mar 2006 07:31:41 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org,
       cramerj@intel.com, john.ronciak@intel.com
Subject: Re: [PATCH]: e1000 endianness bugs
Message-ID: <20060316073141.GA29074@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jeff@garzik.org, cramerj@intel.com,
	john.ronciak@intel.com
References: <20060315.142628.28661597.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315.142628.28661597.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 02:26:28PM -0800, David S. Miller wrote:
> 
> 	return -E_NO_BIG_ENDIAN_TESTING;
> 
> [E1000]: Fix 4 missed endianness conversions on RX descriptor fields.

Could the e1000 maintainers please add endianess annotations so that
sparse will catch such things in the future?

