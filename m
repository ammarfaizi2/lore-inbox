Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUDKRJE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 13:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUDKRJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 13:09:04 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:2573 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262418AbUDKRJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 13:09:02 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Subject: Re: List of oversized inlines
Date: Sun, 11 Apr 2004 20:08:52 +0300
User-Agent: KMail/1.5.4
Cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200404111905.49443.vda@port.imtp.ilyichevsk.odessa.ua> <200404111951.34734.vda@port.imtp.ilyichevsk.odessa.ua> <20040411170340.GB1287@gallifrey>
In-Reply-To: <20040411170340.GB1287@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404112008.52527.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 April 2004 20:03, Dr. David Alan Gilbert wrote:
> Be careful in making judgements about the inlining behaviour based
> on sizes on one architecture.  The size of these functions
> is likely to be radically different on different architectures, and
> the break off point of cache/RAM usage v branch cost is also likely
> to be entirely different.

I know. Other arches can rerun my script and compare results.

I worry more about

inline bogon(int i) {
	if(i) {
		...
	}
}

style inlines. My methos won't catch 'em
--
vda

