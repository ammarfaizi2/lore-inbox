Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292395AbSCST7s>; Tue, 19 Mar 2002 14:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292458AbSCST7j>; Tue, 19 Mar 2002 14:59:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46605 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292368AbSCST7d>; Tue, 19 Mar 2002 14:59:33 -0500
Message-ID: <3C97988B.1030401@zytor.com>
Date: Tue, 19 Mar 2002 11:59:07 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zlib double-free bug
In-Reply-To: <15510.25987.233438.112897@argo.ozlabs.ibm.com> <Pine.LNX.4.44.0203191044150.26226-100000@passion.cambridge.redhat.com> <a77umb$t3s$1@cesium.transmeta.com> <20020319201427.K19346@suse.de> <3C979333.6020500@zytor.com> <20020319205029.L19346@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> On Tue, Mar 19, 2002 at 11:36:19AM -0800, H. Peter Anvin wrote:
> 
>  > Right, but you don't want someone to insert a removable medium and have
>  > the system crash in response.
> 
>  My understanding from one of dwmw2's earlier posts was that jffs2
>  has crc's that would prevent this happening anyway (or at least make
>  it nigh on impossible)
> 


I doubt that.  We're talking about corrupting the kernel VM.

	-hpa



