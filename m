Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261791AbSIZAlO>; Wed, 25 Sep 2002 20:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261807AbSIZAlO>; Wed, 25 Sep 2002 20:41:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23425 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261791AbSIZAlM>;
	Wed, 25 Sep 2002 20:41:12 -0400
Date: Wed, 25 Sep 2002 17:40:19 -0700 (PDT)
Message-Id: <20020925.174019.21928114.davem@redhat.com>
To: niv@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D9259C3.6CA5D211@us.ibm.com>
References: <3D924F9D.C2DCF56A@us.ibm.com>
	<20020925.170336.77023245.davem@redhat.com>
	<3D9259C3.6CA5D211@us.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Nivedita Singhvi <niv@us.ibm.com>
   Date: Wed, 25 Sep 2002 17:50:11 -0700
   
   Well, true - we have per hashchain locks, but are we now adding
   the times we need to lookup something on this chain because we now 
   have additional info other than the route, is what I was
   wondering..?
   
That's what I meant by "extending the lookup key", consider if we
took "next protocol, src port, dst port" into account.
