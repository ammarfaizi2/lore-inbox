Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293035AbSBVW5v>; Fri, 22 Feb 2002 17:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293036AbSBVW5m>; Fri, 22 Feb 2002 17:57:42 -0500
Received: from amdext.amd.com ([139.95.251.1]:7115 "EHLO amdext.amd.com")
	by vger.kernel.org with ESMTP id <S293035AbSBVW5b>;
	Fri, 22 Feb 2002 17:57:31 -0500
From: harish.vasudeva@amd.com
X-Server-Uuid: 02753650-11b0-11d5-bbc5-00508bf987eb
Message-ID: <CB35231B9D59D311B18600508B0EDF2F04F280E6@caexmta9.amd.com>
To: linux-kernel@vger.kernel.org
Subject: Need some help with IP/TCP Checksum Offload
Date: Fri, 22 Feb 2002 14:57:22 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 1068135E4865599-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

 I am trying to offload checksum calculation to my hardware. What i am doing in my driver (kernel 2.4.6) is :

 dev->features = NETIF_F_IP_CHECKSUM;

 Then, in my start_xmit( ) routine, i am parsing for the right headers & when i get the IP/TCP header, i print out the checksum & it is already the right checksum. When does the OS/Protocol offload this task? Am i missing something here?

thanx for your help
HARISH V
Enterprise Connectivity Solutions, AMD
(408) 749-3324 (Work) 
* Knowledge becomes wisdom only after it has been put to practical use.  *


