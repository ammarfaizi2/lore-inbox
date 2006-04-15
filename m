Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWDOBJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWDOBJH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 21:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWDOBJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 21:09:06 -0400
Received: from xproxy.gmail.com ([66.249.82.201]:57138 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751458AbWDOBJF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 21:09:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pv8yp9HdnPZcXr2KdoTapaxxqVECAZkOo2mg4fgpB+cpSHGjILFxgpMzYUQxLnd2V+wazvfFpumwi4gdDMS0LRj9xYqlPnHvRmPNoCYtRbKv0yZUvW0KcWYe1PznWdZ4knkAgqPdCa0UDYbuMiAOCSAaMaA6LU2BL+zxyjQU9Mg=
Message-ID: <369a7ef40604141809u45b7b37ay27dfb74778a91893@mail.gmail.com>
Date: Sat, 15 Apr 2006 03:09:05 +0200
From: "Libor Vanek" <libor.vanek@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Connector - how to start?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'd like to start writing some small module using connector to send
messages to/from user-space. Unfortunately I'm absolutely not familiar
with netlink/connector API usage and I couldn't find any usefull
documentation (yes, I read Documentation/connector/ and tried Google).

So here's things which are not clear to me:
- the Documentation/connector containts only kernel-space example -
don't anybody have also "user-space client example"?
- how do I ACK message sent to/from user-space?
- in case of multiple clients listening how do I send message just to
(random) one (simple load balancing) or to all of them? (broadcasting)
- is there some "easy" way how to send longer messages then
CONNECTOR_MAX_MSG_SIZE?

Thanks for even small hints,
Libor Vanek
