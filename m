Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbVJKUq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbVJKUq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 16:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVJKUqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 16:46:25 -0400
Received: from puma.inf.ufrgs.br ([143.54.11.5]:37074 "EHLO puma.inf.ufrgs.br")
	by vger.kernel.org with ESMTP id S1751326AbVJKUqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 16:46:25 -0400
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E90C20D8-AC5D-4E9E-A477-48164FA0E7EE@inf.ufrgs.br>
Content-Transfer-Encoding: 7bit
X-Image-Url: http://www.inf.ufrgs.br/~drebes/drebes.tif
From: Roberto Jung Drebes <drebes@inf.ufrgs.br>
Subject: Instantiating my own random number generator
Date: Tue, 11 Oct 2005 17:46:18 -0300
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

I have a kernel module which asks for random numbers using  
get_random_bytes().

Is there a way I can set this number generator my own seed value, so  
that I can replay experiments I perform with my module? If I set a  
seed for the whole system, it would affect other kernel tasks  
obtaining random numbers through get_random_bytes(), so I guess that  
is not a good solution.

TIA,

-- 
Roberto Jung Drebes <drebes@inf.ufrgs.br>
Porto Alegre, RS - Brasil
http://www.inf.ufrgs.br/~drebes/


