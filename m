Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280197AbRJaNbq>; Wed, 31 Oct 2001 08:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280214AbRJaNbh>; Wed, 31 Oct 2001 08:31:37 -0500
Received: from dns.irisa.fr ([131.254.254.2]:13516 "HELO dns.irisa.fr")
	by vger.kernel.org with SMTP id <S280211AbRJaNbX>;
	Wed, 31 Oct 2001 08:31:23 -0500
Date: Wed, 31 Oct 2001 14:31:59 +0100
From: DINH Viet Hoa <Viet-Hoa.Dinh@irisa.fr>
To: linux-kernel@vger.kernel.org
Subject: current->addr_limit
Message-Id: <20011031143159.0bdc0981.vdinh@irisa.fr>
Organization: IRISA
X-Mailer: Sylpheed version 0.6.4claws12 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When changing current->addr_limit through the macros 
get_fs() and set_fs() in the kernel or in a kernel thread,
do we need to lock anything to prevent anything else
from accessing our custom value of current->addr_limit ?

thanks.

-- 
DINH Viêt Hoà, ingénieur associé, projet PARIS
IRISA-INRIA, Campus de Beaulieu, 35042 Rennes cedex, France
Tél: +33 (0) 2 99 84 75 98, Fax: +33 (0) 2 99 84 25 28
