Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVFERlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVFERlm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 13:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVFERlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 13:41:42 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:55885 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261588AbVFERli convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 13:41:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=b7TN+J1De70muhg306xbhH00ga4PlGpNZJSnVMNDbNv7nypR/oWlpjKYudhVh28Tm5or0RHG7Ahmm8nQNLCjjcVK7I+/JmQgY33FnHX6K4wMIeGNyaH5BklD9fja/yBmcojUmOlXJ7fJ/7LQ3oDXNqmuYo2+mYc5C3HqskpqESc=
Message-ID: <54b5dbf5050605104148fc14c6@mail.gmail.com>
Date: Sun, 5 Jun 2005 23:11:38 +0530
From: AsterixTheGaul <asterixthegaul@gmail.com>
Reply-To: AsterixTheGaul <asterixthegaul@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc5-git-<june-2>: net modules disagree about missing symbols.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get following errors whenver I try to load some net modules like e1000/ipv6.
Let me know if I could be of any help.



Jun  3 15:55:29 localhost kernel: e1000: disagrees about version of
symbol per_cpu__softnet_data
Jun  3 15:55:29 localhost kernel: e1000: Unknown symbol per_cpu__softnet_data
Jun  3 15:55:29 localhost kernel: e1000: disagrees about version of
symbol ethtool_op_get_tso
Jun  3 15:55:29 localhost kernel: e1000: Unknown symbol ethtool_op_get_tso
Jun  3 15:55:29 localhost kernel: e1000: disagrees about version of
symbol unregister_netdev
Jun  3 15:55:29 localhost kernel: e1000: Unknown symbol unregister_netdev
Jun  3 15:55:29 localhost kernel: e1000: disagrees about version of
symbol pskb_expand_head
Jun  3 15:55:29 localhost kernel: e1000: Unknown symbol pskb_expand_head
Jun  3 15:55:29 localhost kernel: e1000: disagrees about version of
symbol eth_type_trans
Jun  3 15:55:29 localhost kernel: e1000: Unknown symbol eth_type_trans
Jun  3 15:55:29 localhost kernel: e1000: disagrees about version of
symbol ethtool_op_set_sg
Jun  3 15:55:29 localhost kernel: e1000: Unknown symbol ethtool_op_set_sg
Jun  3 15:55:29 localhost kernel: e1000: disagrees about version of
symbol skb_over_panic
Jun  3 15:55:29 localhost kernel: e1000: Unknown symbol skb_over_panic
Jun  3 15:55:29 localhost kernel: e1000: disagrees about version of
symbol netif_receive_skb
Jun  3 15:55:29 localhost kernel: e1000: Unknown symbol netif_receive_skb
Jun  3 15:55:29 localhost kernel: e1000: disagrees about version of
symbol register_netdev
Jun  3 15:55:29 localhost kernel: e1000: Unknown symbol register_netdev
Jun  3 15:55:29 localhost kernel: e1000: disagrees about version of
symbol free_netdev
Jun  3 15:55:29 localhost kernel: e1000: Unknown symbol free_netdev
Jun  3 15:55:29 localhost kernel: e1000: disagrees about version of
symbol alloc_skb
Jun  3 15:55:29 localhost kernel: e1000: Unknown symbol alloc_skb
Jun  3 15:55:29 localhost kernel: e1000: disagrees about version of
symbol ethtool_op_get_link
Jun  3 15:55:29 localhost kernel: e1000: Unknown symbol ethtool_op_get_link
Jun  3 15:55:29 localhost kernel: e1000: disagrees about version of
symbol __netdev_watchdog_up
Jun  3 15:55:29 localhost kernel: e1000: Unknown symbol __netdev_watchdog_up
Jun  3 15:55:29 localhost kernel: e1000: disagrees about version of
symbol linkwatch_fire_event
Jun  3 15:55:29 localhost kernel: e1000: Unknown symbol linkwatch_fire_event
Jun  3 15:55:29 localhost kernel: e1000: disagrees about version of
symbol ethtool_op_get_sg
Jun  3 15:55:29 localhost kernel: e1000: Unknown symbol ethtool_op_get_sg
Jun  3 15:55:29 localhost kernel: e1000: disagrees about version of
symbol alloc_etherdev
Jun  3 15:55:29 localhost kernel: e1000: Unknown symbol alloc_etherdev
Jun  3 15:55:29 localhost kernel: e1000: disagrees about version of
symbol __kfree_skb
Jun  3 15:55:29 localhost kernel: e1000: Unknown symbol __kfree_skb
