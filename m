Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbTCCJqf>; Mon, 3 Mar 2003 04:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTCCJqf>; Mon, 3 Mar 2003 04:46:35 -0500
Received: from holomorphy.com ([66.224.33.161]:49810 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262289AbTCCJqe>;
	Mon, 3 Mar 2003 04:46:34 -0500
Date: Mon, 3 Mar 2003 01:56:43 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: Re: [PATCH] Another bitop on boolean in pnpbios
Message-ID: <20030303095643.GO1195@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org,
	ambx1@neo.rr.com
References: <20030303054235.GA58427@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303054235.GA58427@compsoc.man.ac.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 05:42:35AM +0000, John Levon wrote:
>  #define pnpbios_is_static(x) ((x)->flags & 0x0100) == 0x0000
> -#define pnpbios_is_dynamic(x) (x)->flags & 0x0080
> +#define pnpbios_is_dynamic(x) ((x)->flags & 0x0080)

pnpbios_is_static() could probably use the same treatment.


-- wli
