Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317978AbSHZHdC>; Mon, 26 Aug 2002 03:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317980AbSHZHdC>; Mon, 26 Aug 2002 03:33:02 -0400
Received: from [62.40.73.125] ([62.40.73.125]:47539 "HELO Router")
	by vger.kernel.org with SMTP id <S317978AbSHZHdB>;
	Mon, 26 Aug 2002 03:33:01 -0400
Date: Mon, 26 Aug 2002 09:36:44 +0200
From: Jan Hudec <bulb@cimice.maxinet.cz>
To: Zheng Jian-Ming <zjm@cis.nctu.edu.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to use clone flas CLONE_THREAD?
Message-ID: <20020826073644.GA1052@vagabond>
Mail-Followup-To: Jan Hudec <bulb@cimice.maxinet.cz>,
	Zheng Jian-Ming <zjm@cis.nctu.edu.tw>, linux-kernel@vger.kernel.org
References: <20020826044541.GA19337@cissol7.cis.nctu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020826044541.GA19337@cissol7.cis.nctu.edu.tw>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 12:45:41PM +0800, Zheng Jian-Ming wrote:
> When i use clone flag CLONE_THREAD and compiled my program, i get the error
> message: `CLONE_THREAD' undeclared (first use in this function)"
> 
> Is this flag still not available unless we use thread package such as NGPT?
> 
> How to use CLONE_THREAD flag? Thank you.

You get suffciently recent kernel headers for libc. Libc might need
recompiling when you do that.

The reason is, that now /usr/include/linux is no longer a link to kernel
sources in most distribution, since it was found, that there can be
problems when application is compiled with different headers than libc.
Thus you need to instal new headers and may need recompiling libc if
problems show up.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
