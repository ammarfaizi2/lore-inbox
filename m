Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278695AbRKALHu>; Thu, 1 Nov 2001 06:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278701AbRKALHk>; Thu, 1 Nov 2001 06:07:40 -0500
Received: from castle.nmd.msu.ru ([193.232.112.53]:531 "HELO castle.nmd.msu.ru")
	by vger.kernel.org with SMTP id <S278700AbRKALHe>;
	Thu, 1 Nov 2001 06:07:34 -0500
Message-ID: <20011101141506.B27180@castle.nmd.msu.ru>
Date: Thu, 1 Nov 2001 14:15:06 +0300
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Johan <jo_ni@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Still having problems with eepro100
In-Reply-To: <20011030123927.74e26501.jo_ni@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20011030123927.74e26501.jo_ni@telia.com>; from "Johan" on Tue, Oct 30, 2001 at 12:39:27PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 12:39:27PM +0100, Johan wrote:
> 
> Hello,
> Does anyone except me still having problems with the eepro100 drivers ?
> 
> The network connection stalls and I'll get this message:
> 
> eepro100: wait_for_cmd_done timeout!

Try to add `udelay(1);' inside the loop in wait_for_cmd_done().
It helped to some people with same problems.

	Andrey
