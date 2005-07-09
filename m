Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVGIVGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVGIVGw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 17:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVGIVGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 17:06:52 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:6583 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261730AbVGIVGv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 17:06:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sEAHc/N23BhQ5JCi+dDqRVAUkSpGinVhxP8svfLucf6AxowoZD/tBGk27tMRHt3kpzWZQ5hS9Dv2XB4EdTCgSTal4KiQhb4ymTmpi5Ag3smegWAD42EkfAIKvkoBpf775o0eMLK9YAlN+o+48DRIghJcT82QVe0WELDhZAR17dQ=
Message-ID: <31d23c6905070914064700b2bd@mail.gmail.com>
Date: Sat, 9 Jul 2005 23:06:51 +0200
From: Jaroslav Soltys <jaro.soltys@gmail.com>
Reply-To: Jaroslav Soltys <jaro.soltys@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: proper network intarface behaviour ?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

i have two disjunct networks with only one computer connected to both
of them. I did the following setup:

eth0: 192.168.111.13/24
eth1: 158.195.100.248/22

later i added eth0:0 158.195.101.13/22

i did ssh user@158.195.101.13 from the eth1's network, but notice the
eth0:0's address.
ip_forward was 0, rp_filter was 1.

i suppose this behaviour is incorrect. is it ?

jaro soltys
