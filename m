Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265649AbUFIGuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbUFIGuo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 02:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265650AbUFIGuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 02:50:44 -0400
Received: from web52205.mail.yahoo.com ([206.190.39.87]:29285 "HELO
	web52205.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265649AbUFIGul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 02:50:41 -0400
Message-ID: <20040609065040.5847.qmail@web52205.mail.yahoo.com>
Date: Tue, 8 Jun 2004 23:50:40 -0700 (PDT)
From: linux lover <linux_lover2004@yahoo.com>
Subject: tcp_sendmsg working
To: linuxkernel <linux-kernel@vger.kernel.org>
Cc: linuxnet <linux-net@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello,
how tcp_sendmsg add message from application layer to
socket buffer skb? 

i am unable to find message field in msghdr help me.
struct msghdr {
        void    *       msg_name;       /* Socket name
                 
*/
        int             msg_namelen;    /* Length of
name               
*/
        struct iovec *  msg_iov;        /* Data blocks
                 
*/
        __kernel_size_t msg_iovlen;     /* Number of
blocks             
*/
        void    *       msg_control;    /* Per
protocol magic (eg BSD 
file descriptor passing) */
        __kernel_size_t msg_controllen; /* Length of
cmsg list */
        unsigned        msg_flags;
};
also what is use of struct iovec? is that store actual
data? if yes then how that is included in socket
buffer?

regards,
linux_lover



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
