Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314041AbSDKNAj>; Thu, 11 Apr 2002 09:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314042AbSDKNAi>; Thu, 11 Apr 2002 09:00:38 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:49157 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314041AbSDKNAi>; Thu, 11 Apr 2002 09:00:38 -0400
Message-Id: <200204111257.g3BCvOX10348@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "David S. Miller" <davem@redhat.com>, taka@valinux.co.jp
Subject: Re: [PATCH] zerocopy NFS updated
Date: Thu, 11 Apr 2002 16:00:37 -0200
X-Mailer: KMail [version 1.3.2]
Cc: ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20020411.164134.85392767.taka@valinux.co.jp> <20020411.203823.67879801.taka@valinux.co.jp> <20020411.043614.02328218.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 April 2002 09:36, David S. Miller wrote:
> No, you must block truncate operations on the file until the client
> ACK's the nfsd read request if you wish to use sendfile() with
> nfsd.

Which shouldn't be a big performance problem unless I am unaware
of some real-life applications doing heavy truncates.
--
vda
