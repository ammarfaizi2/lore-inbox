Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbTD3IAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 04:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTD3IAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 04:00:36 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:48846 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261308AbTD3IAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 04:00:34 -0400
From: Christian =?iso-8859-1?q?Borntr=E4ger?= <linux@borntraeger.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [BUG 2.5.67 (and probably earlier)] /proc/dev/net doesnt show all net devices
Date: Wed, 30 Apr 2003 10:12:39 +0200
User-Agent: KMail/1.5.1
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
References: <200304291434.18272.linux@borntraeger.net> <20030429092857.4ebffcc9.rddunlap@osdl.org> <20030429130742.2c38b5f3.rddunlap@osdl.org>
In-Reply-To: <20030429130742.2c38b5f3.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304301012.39121.linux@borntraeger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 April 2003 22:07, Randy.Dunlap wrote:
> Oh well, I don't think that works.

Well, it fails differently. Now i get all devices but several times.

[root@tel22fe root]# cat /proc/net/dev
Inter-|   Receive                                                |  Transmit
 face |bytes    packets errs drop fifo frame compressed multicast|bytes    
packets errs drop fifo colls carrier compressed
    lo:     784      10    0    0    0     0          0         0      784      
dummy0:       0       0    0    0    0     0          0         0        0       
 tunl0:       0       0    0    0    0     0          0         0        0       
  gre0:       0       0    0    0    0     0          0         0        0       
  sit0:       0       0    0    0    0     0          0         0        0       
  eth0:   13356     148    0    0    0     0          0         0    27388     
  eth1:     805       3    0    0    0     0          0         0      264       
dummy0:       0       0    0    0    0     0          0         0        0       
 tunl0:       0       0    0    0    0     0          0         0        0       
  gre0:       0       0    0    0    0     0          0         0        0       
  sit0:       0       0    0    0    0     0          0         0        0       
  eth0:   13356     148    0    0    0     0          0         0    27388     
  eth1:     805       3    0    0    0     0          0         0      264       
  eth2:       0       0    0    0    0     0          0         0      264       
  hsi0:       0       0    0    0    0     0          0         0      264       
 tunl0:       0       0    0    0    0     0          0         0        0       
  gre0:       0       0    0    0    0     0          0         0        0       
  sit0:       0       0    0    0    0     0          0         0        0       
  eth0:   13356     148    0    0    0     0          0         0    27388     
  eth1:     805       3    0    0    0     0          0         0      264       
  eth2:       0       0    0    0    0     0          0         0      264       
  hsi0:       0       0    0    0    0     0          0         0      264       
  gre0:       0       0    0    0    0     0          0         0        0       
  sit0:       0       0    0    0    0     0          0         0        0       
  eth0:   13356     148    0    0    0     0          0         0    28544     
  eth1:     805       3    0    0    0     0          0         0      264       
  eth2:       0       0    0    0    0     0          0         0      264       
  hsi0:       0       0    0    0    0     0          0         0      264       
  sit0:       0       0    0    0    0     0          0         0        0       
  eth0:   13356     148    0    0    0     0          0         0    28544     
  eth1:     805       3    0    0    0     0          0         0      264       
  eth2:       0       0    0    0    0     0          0         0      264       
  hsi0:       0       0    0    0    0     0          0         0      264       
  eth0:   13356     148    0    0    0     0          0         0    29700     
  eth1:     805       3    0    0    0     0          0         0      264       
  eth2:       0       0    0    0    0     0          0         0      264       
  hsi0:       0       0    0    0    0     0          0         0      264       
  eth1:     805       3    0    0    0     0          0         0      264       
  eth2:       0       0    0    0    0     0          0         0      264       
  hsi0:       0       0    0    0    0     0          0         0      264       
  eth2:       0       0    0    0    0     0          0         0      264       
  hsi0:       0       0    0    0    0     0          0         0      264       
  hsi0:       0       0    0    0    0     0          0         0      264       

