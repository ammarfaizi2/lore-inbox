Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292289AbSCSTus>; Tue, 19 Mar 2002 14:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292316AbSCSTui>; Tue, 19 Mar 2002 14:50:38 -0500
Received: from ns.suse.de ([213.95.15.193]:20242 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292289AbSCSTub>;
	Tue, 19 Mar 2002 14:50:31 -0500
Date: Tue, 19 Mar 2002 20:50:29 +0100
From: Dave Jones <davej@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zlib double-free bug
Message-ID: <20020319205029.L19346@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <15510.25987.233438.112897@argo.ozlabs.ibm.com> <Pine.LNX.4.44.0203191044150.26226-100000@passion.cambridge.redhat.com> <a77umb$t3s$1@cesium.transmeta.com> <20020319201427.K19346@suse.de> <3C979333.6020500@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 11:36:19AM -0800, H. Peter Anvin wrote:

 > Right, but you don't want someone to insert a removable medium and have
 > the system crash in response.

 My understanding from one of dwmw2's earlier posts was that jffs2
 has crc's that would prevent this happening anyway (or at least make
 it nigh on impossible)
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
